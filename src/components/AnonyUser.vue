<template>
  <div>
    <button class="bg-green-500 hover:bg-green-600" @click="signInAuth">
      Non User
    </button>
  </div>
</template>

<script>
import { useAnonymousAuth } from '@/firebase'

export default {
  name: 'AnonymousLoginForm',
  setup() {
    const { signInAuth } = useAnonymousAuth()

    return {
      signInAuth
    }
  }
}
</script>