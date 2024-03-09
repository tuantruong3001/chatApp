<template>
  <div>
    <h1>User List</h1>
    <ul>
      <li v-for="user in users" :key="user.id">
        {{ user.name }}
      </li>
    </ul>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import { useUsers } from '@/firebase' // Assuming you have a useUsers function in firebase.js

export default {
  name: 'UserList',
  setup() {
    const users = ref([])

    onMounted(async () => {
      users.value = await useUsers() // Fetch users when the component is mounted
    })

    return { users }
  }
}
</script>