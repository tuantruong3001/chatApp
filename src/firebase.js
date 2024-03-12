import firebase from 'firebase/app'
import 'firebase/auth'
import 'firebase/firestore'
import 'firebase/storage'

import Filter from 'bad-words'
import { ref, onUnmounted, computed } from 'vue'

firebase.initializeApp({
  apiKey: process.env.VUE_APP_API_KEY,
  authDomain: process.env.VUE_APP_AUTH_DOMAIN,
  databaseURL: process.env.VUE_APP_DATABASE_URL,
  projectId: process.env.VUE_APP_PROJECT_ID,
  storageBucket: process.env.VUE_APP_STORAGE_BUCKET,
  messagingSenderId: process.env.VUE_APP_MESSAGING_SENDER_ID,
  appId: process.env.VUE_APP_APP_ID,
  measurementId: process.env.VUE_APP_MEASUREMENT_ID
})

const auth = firebase.auth()

export function useAuth() {
  const user = ref(null)
  const unsubscribe = auth.onAuthStateChanged(_user => (user.value = _user))
  onUnmounted(unsubscribe)
  const isLogin = computed(() => user.value !== null)

  const signIn = async () => {
    const googleProvider = new firebase.auth.GoogleAuthProvider()
    await auth.signInWithPopup(googleProvider)
  }
  const signOut = () => auth.signOut()

  return { user, isLogin, signIn, signOut }
}

export function useAnonymousAuth() {
  const user = ref(null)
  const unsubscribe = auth.onAuthStateChanged(_user => (user.value = _user))
  onUnmounted(unsubscribe)
  const isLogin = computed(() => user.value !== null)

  const signInAuth = async () => {
    await auth.signInAnonymously()
  }
  const signOut = () => auth.signOut()

  return { user, isLogin, signInAuth, signOut }
}

const firestore = firebase.firestore()
const messagesCollection = firestore.collection('messages')
const messagesQuery = messagesCollection.orderBy('createdAt', 'desc').limit(15)
const filter = new Filter()

export function useChat() {
  const messages = ref([])
  const unsubscribe = messagesQuery.onSnapshot(snapshot => {
    messages.value = snapshot.docs
      .map(doc => ({ id: doc.id, ...doc.data() }))
      .reverse()
  })
  onUnmounted(unsubscribe)

  const { user, isLogin } = useAuth() || useAnonymousAuth()
  const sendMessage = (text, imageUrl) => {
    if (!isLogin.value) return
    const { photoURL, uid, displayName } = user.value
    messagesCollection.add({
      userName: displayName,
      userId: uid,
      userPhotoURL: photoURL,
      text: filter.clean(text),
      imageUrl: imageUrl, // Add this line
      createdAt: firebase.firestore.FieldValue.serverTimestamp()
    })
  }

  return { messages, sendMessage }
}
const useStorage = () => {
  const error = ref(null)
  const url = ref(null)
  const uploadImage = async (image) => {
    const storageRef = firebase.storage().ref(`images/${image.name}`)
    try {
      const res = await storageRef.put(image)
      url.value = await res.ref.getDownloadURL()
    } catch (err) {
      console.error(err.message)
      error.value = err.message
    }
    return url.value; // Return the URL of the uploaded file
  };

  return { url, error, uploadImage }
};

export default useStorage