<template>
  <div class="container-sm mt-20">
    <div class="mx-5">
      <Message
        v-for="{ id, text, userPhotoURL, userName, userId, imageUrl } in messages"
        :key="id"
        :name="userName"
        :photo-url="userPhotoURL"
        :sender="userId === user?.uid"
        :imageUrl="imageUrl">
        {{ text }}
      </Message>
    </div>
  </div>

  <div ref="bottom" class="mt-20" />

  <div class="bottom">
    <div class="container-sm">
      <form v-if="isLogin" @submit.prevent="send">
        <input v-model="message" placeholder="Message" required />
        <input type="file" @change="onFileChange" id="files" name="files[]" multiple />
        <button type="submit">
          <SendIcon />
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import { ref, watch, nextTick } from 'vue';
import { useAuth, useChat } from '@/firebase';
import useStorage from '@/firebase';

import SendIcon from './SendIcon.vue';
import Message from './Message.vue';

export default {
  components: { Message, SendIcon },
  setup() {
    const { user, isLogin } = useAuth();
    const { messages, sendMessage } = useChat();
    const { uploadImage } = useStorage(); // Correctly use uploadImage from useStorage

    const bottom = ref(null);
    const message = ref('');
    const image = ref(null);

    watch(messages, () => {
      nextTick(() => {
        bottom.value?.scrollIntoView({ behavior: 'smooth' });
      });
    }, { deep: true });

    const send = async () => {
      let imageUrl = '';
      if (image.value) {
        imageUrl = await uploadImage(image.value); // Now correctly calling uploadImage
      }
      sendMessage(message.value, imageUrl);
      message.value = '';
      image.value = null;
    };

    const onFileChange = (e) => {
      image.value = e.target.files[0];
    };

    return { user, isLogin, messages, bottom, message, image, send, onFileChange };
  }
};
</script>
