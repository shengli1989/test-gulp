<style lang="sass" src="app.sass"></style>

<template lang="jade">
.App(v-bind:class="{ 'is-sideActive': isSideActive }")
  menu(:archives='archives' v-bind:current-archive='currentArchive' v-bind:is-active='isSideActive')
  medium(:current-archive='currentArchive' v-bind:is-side-active='isSideActive')
</template>

<script lang="coffee">
  module.exports =
    data: ->
      archives: archiveData
      currentArchive: null
      isSideActive: true
    components:
      'menu': require './menu.vue'
      'medium': require './medium.vue'
    created: ->
      @currentArchive = @archives[@archives.length - 1]
    methods:
      changeArchive: (archive) ->
        @currentArchive = archive
    events:
      'archive-change': (archive) ->
        @changeArchive(archive)
      'menu-toggle': ->
        @isSideActive = !@isSideActive
</script>
