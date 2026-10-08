"""Project CRUD with RBAC + audit (stdlib logic)."""
from ..core.rbac import audit_record, require


class ProjectService:
    def __init__(self, store):
        self.store = store

    def create(self, actor, name):
        require(actor["role"], "project.create")
        name = (name or "").strip()
        if not name or len(name) > 128:
            raise ValueError("project name must be 1-128 characters")
        project = self.store.create_project(name, actor["sub"])
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="project.create",
            target=project["id"], result="ok", detail={"name": name}))
        return project

    def list(self, actor):
        require(actor["role"], "project.read")
        return self.store.list_projects()

    def get(self, actor, project_id):
        require(actor["role"], "project.read")
        project = self.store.get_project(project_id)
        if not project:
            raise LookupError("project not found")
        return project

    def delete(self, actor, project_id):
        require(actor["role"], "project.delete")
        if not self.store.get_project(project_id):
            raise LookupError("project not found")
        self.store.delete_project(project_id)
        self.store.append_audit(audit_record(
            actor=actor["sub"], action="project.delete",
            target=project_id, result="ok"))
