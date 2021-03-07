<template>
  <v-footer color="#fafaf9" height="160">
    <v-row no-gutters >
      <v-col lg=3 />
      <v-col lg=9>
      <v-btn
        v-for="(n, index) in items"
        :key="index"
        color="#979dac"
        text
        small
        rounded>
        <div>
          {{ n }}
        </div>
      </v-btn>
      </v-col>
    </v-row>
  </v-footer>
</template>

<script>
export default {
  name: "TheFooter",
  data() {
    return {
      items: {
        strong: new Date().getFullYear() + "C",
        about: "質問・問い合わせ",
        help: "プライバシーポリシー",
        rule: "利用規約",
        raw: "特定商取引法に関する表記",
        developer: "運営",
      }
      }
    }
  }
</script>