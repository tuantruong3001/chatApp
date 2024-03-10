<template>
  <div class="container-sm mt-20">
    <div class="mx-5">
      <Message
        v-for="{ id, text, userPhotoURL, userName, userId } in messages"
        :key="id"
        :name="userName"
        :photo-url="userPhotoURL"
        :sender="userId === user?.uid"
      >
        {{ text }}
      </Message>
    </div>
  </div>

  <div ref="bottom" class="mt-20" />

  <div class="bottom">
    <div class="container-sm">
      <form v-if="isLogin" @submit.prevent="send">
        <input v-model="message" placeholder="Message" required />
        <input type="file" onchange="onFileChange()" id="files" name="files[]" multiple />
        <button type="submit">
          <SendIcon />
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import { ref, watch, nextTick } from 'vue'
import { useAuth, useChat } from '@/firebase'
import { useStorage } from '@/firebase'

import SendIcon from './SendIcon.vue'
import Message from './Message.vue'

export default {
  components: { Message, SendIcon },
  setup() {
    const { user, isLogin } = useAuth()
    const { messages, sendMessage } = useChat()

    const bottom = ref(null)
    watch(
      messages,
      () => {
        nextTick(() => {
          bottom.value?.scrollIntoView({ behavior: 'smooth' })
        })
      },
      { deep: true }
    )

    const message = ref('')
    const image = ref(null) // Add a ref for the image file
    const send = async () => {
      let imageUrl = ''
      if (image.value) {
        imageUrl = await useStorage(image.value) // Upload the image and get the URL
      }
      sendMessage(message.value, imageUrl) // Send the message with the image URL
      message.value = ''
      image.value = null
    }
    const onFileChange = (e) => {
      image.value = e.target.files[0]
    }
    return { user, isLogin, messages, bottom, message, image, send, onFileChange } // Add onFileChange here
  }
}
</script>
