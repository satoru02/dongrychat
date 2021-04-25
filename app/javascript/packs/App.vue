<template>
  <main-part />
</template>

<script>
  import MainPart from '../components/Layout/TheMainPart'

  export default {
    name: 'App',
    components: {
      'main-part': MainPart
    },
    created(){
      this.createCable()
    },
    channels: {
      AppearanceChannel: {
        connected(){},
        rejected(){},
        received(data){
          console.log(data)
        },
        disconnected(){}
      }
    },
    methods: {
      createCable(){
        this.$cable.subscribe({
          channel: 'AppearanceChannel',
        })
      }
    }
  }
</script>

<style>
.v-application {
  font-family: 'Helvetica Neue", Arial, "Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;';
  line-height: 1.5;
}
</style>