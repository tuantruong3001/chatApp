<template>
  <nav>
    <div>
      <h1><strong>Discord Fake</strong></h1>

      <div v-if="isLogin" class="login">
        <Avatar :src="user.photoURL || randomImage" />
        <button class="text-gray-400 hover:text-white" @click="signOut">
          Sign Out
        </button>
      </div>

      <button v-else class="bg-green-500 hover:bg-green-600" @click="signIn">
        Sign in
      </button>
      <AnonyUser />
    </div>
  </nav>
</template>

<script>
import Avatar from './Avatar.vue'
import AnonyUser from './AnonyUser.vue'
import { useAuth } from '@/firebase'

const images = require.context('@/images', false, /\.jpg$/)
const imageArray = images.keys().map(images)

export default {
  components: { Avatar },
  setup() {
    const { user, isLogin, signOut, signIn } = useAuth()
    const randomImage =
      imageArray[Math.floor(Math.random() * imageArray.length)]
    return { user, isLogin, signOut, signIn, randomImage, AnonyUser }
  }
}
</script>
