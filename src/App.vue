<template>
  <Nav />
  <Chat />
  <AnonyUser />
</template>

<script>
import Nav from '@/components/Nav.vue'
import Chat from '@/components/Chat.vue'
import AnonyUser from "@/components/AnonyUser.vue";

export default {
  name: 'App',
  components: { Nav, Chat, AnonyUser },
}
</script>
