<template>
  <div class="message">
    <span v-if="!sender">{{ name }}</span>
    <div class="flex" :class="sender ? 'flex-row-reverse' : ''">
      <Avatar class="mt-1" :src="photoUrl || randomImage" />
      <div class="text w-3/4" :class="sender ? 'bg-green-800' : 'bg-gray-700'" style="width: auto">
        <slot />
      </div>
    </div>
  </div>
  <img v-if="imageUrl" :src="imageUrl" alt="Sent image" class="message-image" />

</template>

<script>
import Avatar from './Avatar.vue'

const images = require.context('@/images', false, /\.jpg$/)
const imageArray = images.keys().map(images)

export default {
  components: { Avatar },
  props: {
    name: { type: String, default: '' },
    photoUrl: { type: String, default: '' },
    sender: { type: Boolean, default: false },
    imageUrl: String
  },
  data() {
    const randomImage =
      imageArray[Math.floor(Math.random() * imageArray.length)]
    return { randomImage }
  }
}
</script>
<style scoped>
.message-image {
  width: auto; /* Adjust as needed */
  height: 200px; /* Adjust as needed */
  margin-right: 40px;
  margin-bottom: 60px;
  flex-direction: row-reverse;
}
</style>
