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
        <label for="uploadFile1"
               class="bg-gray-800 hover:bg-gray-700 text-white text-sm px-4 py-2.5 outline-none rounded w-max cursor-pointer mx-auto block font-[sans-serif]">
          <svg xmlns="http://www.w3.org/2000/svg" class="w-5 mr-2 fill-white inline" viewBox="0 0 32 32">
            <path
              d="M23.75 11.044a7.99 7.99 0 0 0-15.5-.009A8 8 0 0 0 9 27h3a1 1 0 0 0 0-2H9a6 6 0 0 1-.035-12 1.038 1.038 0 0 0 1.1-.854 5.991 5.991 0 0 1 11.862 0A1.08 1.08 0 0 0 23 13a6 6 0 0 1 0 12h-3a1 1 0 0 0 0 2h3a8 8 0 0 0 .75-15.956z"
              data-original="#000000" />
            <path
              d="M20.293 19.707a1 1 0 0 0 1.414-1.414l-5-5a1 1 0 0 0-1.414 0l-5 5a1 1 0 0 0 1.414 1.414L15 16.414V29a1 1 0 0 0 2 0V16.414z"
              data-original="#000000" />
          </svg>
          Upload
          <input class="hidden" type="file" @change="onFileChange" id="uploadFile1" name="files[]" multiple />
        </label>
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
