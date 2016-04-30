<template lang="jade">
  .Medium
    .ScreenWrapper
      iframe(v-bind:src='currentArchive.folder')
</template>

<script lang="coffee">
module.exports =
  props: [
    'current-archive'
    'is-side-active'
  ]
</script>
