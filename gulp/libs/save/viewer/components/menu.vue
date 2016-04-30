<style lang="sass" src="menu.sass"></style>

<template lang="jade">
.Menu(v-bind:class="{ 'is-active': isActive }")
  header.Menu-block.Head
    h1.Head-title Time Machine
    .Head-toggler(@click='toggleMenu()')
    card(:archive='currentArchive')
  .Menu-block
    p RWD mode #[span OFF]
  .Menu-block.Filters
    a.Filters-item(v-for='label in labels' @click='toggleLabel(label)' v-bind:class="{ 'is-checked': label == currentFilter }") {{label}}
  .Menu-block.Search
    a.Search-scope(:class="{ 'is-checked': findExternal }" @click='toggleScope()') external
    input(type='text' v-model='searchComment' placeholder='search')
  .Menu-block.Results
    ul.Results-list
      li.Results-item(v-for="archive in archives | matchBranch | matchScope | matchComment | orderByDate 'datetime' -1")
        card.Results-link(:archive='archive' @click='changeArchive(archive)' v-bind:class="{'is-active': currentArchive == archive}")
</template>

<script lang="coffee">
moment = require 'moment'
_ =
  includes: require 'lodash/includes'

module.exports =
  props: [
    'archives'
    'current-archive'
    'is-active'
  ]
  components:
    'card': require './card.vue'
  data: ->
    labels: ['master', 'fea', 'fix', 'improve']
    currentFilter: ''
    searchComment: ''
    findExternal: false
  methods:
    changeArchive: (archive) ->
      @$dispatch('archive-change', archive)
    toggleMenu: ->
      @$dispatch('menu-toggle')
    toggleLabel: (label) ->
      @currentFilter = if @currentFilter == label then '' else label
    toggleScope: ->
      @findExternal = !@findExternal

  filters:
    matchComment: (arr) ->
      !@searchComment && arr || arr.filter (archive) => _.includes(archive.comment, @searchComment)
    matchScope: (arr) ->
      !@findExternal  && arr || arr.filter (archive) => archive.isExternal
    matchBranch: (arr) ->
      !@currentFilter && arr || arr.filter (archive) => _.includes(archive.branch, @currentFilter)
    orderByDate: (arr, sortKey, reverse) ->
      return arr unless sortKey
      order = reverse && reverse < 0 && -1 || 1

      arr.slice().sort (a, b) ->
        if moment(a[sortKey]).diff(moment(b[sortKey])) > 0 then order else -order
</script>
