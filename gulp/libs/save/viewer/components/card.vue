<style lang="sass" src="card.sass"></style>

<template lang="jade">
  .Card(:class="{ 'is-external': archive.isExternal }")
    .Card-info
      .Card-time {{ archive.datetime | moment }}
      .Card-branch {{ archive.branch }}
      .Card-comment(v-if='archive.comment') {{ archive.comment }}
</template>

<script lang="coffee">
  module.exports =
    props: ['archive']
</script>
