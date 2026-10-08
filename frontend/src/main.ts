import { createApp } from 'vue'
import { createPinia } from 'pinia'
import PrimeVue from 'primevue/config'
import Button from 'primevue/button'
import InputText from 'primevue/inputtext'
import Password from 'primevue/password'
import Card from 'primevue/card'
import DataTable from 'primevue/datatable'
import Column from 'primevue/column'
import ProgressBar from 'primevue/progressbar'
import Message from 'primevue/message'
import Dropdown from 'primevue/dropdown'
import Badge from 'primevue/badge'
import Textarea from 'primevue/textarea'
import Checkbox from 'primevue/checkbox'
import Tag from 'primevue/tag'
import 'primevue/resources/themes/lara-light-blue/theme.css'
import 'primeicons/primeicons.css'
import App from './App.vue'
import './style.css'

const app = createApp(App)
app.use(createPinia())
app.use(PrimeVue, { ripple: true })
app.component('Button', Button)
app.component('InputText', InputText)
app.component('Password', Password)
app.component('Card', Card)
app.component('DataTable', DataTable)
app.component('Column', Column)
app.component('ProgressBar', ProgressBar)
app.component('Message', Message)
app.component('Dropdown', Dropdown)
app.component('Badge', Badge)
app.component('Textarea', Textarea)
app.component('Checkbox', Checkbox)
app.component('Tag', Tag)
app.mount('#app')
