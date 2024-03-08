<template>
  <div class="message">
    <span v-if="!sender">{{ name }}</span>
    <div class="flex" :class="sender ? 'flex-row-reverse' : ''">
      <Avatar class="mt-1" :src="photoUrl || randomImage" />
      <div class="text w-3/4" :class="sender ? 'bg-green-800' : 'bg-gray-700'">
        <slot />
      </div>
    </div>
  </div>
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
    sender: { type: Boolean, default: false }
  },
  data() {
    const randomImage =
      imageArray[Math.floor(Math.random() * imageArray.length)]
    return { randomImage }
  }
}
</script>
