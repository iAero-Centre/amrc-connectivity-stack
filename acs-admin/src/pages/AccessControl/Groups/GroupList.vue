<!--
  - Copyright (c) University of Sheffield AMRC 2024.
  -->
<template>
  <Skeleton v-if="g.loading" v-for="i in 10" class="h-16 rounded-lg mb-2"/>
  <DataTable v-else :data="g.data" :default-sort="initialSort" :columns="columns" :filters="[{
        name: 'Name',
        property: 'name',
        options: filterOptions.names
      }, {
        name: 'Group Type',
        property: 'class',
        options: filterOptions.class,
      }, {
        name: 'Member Count',
        property: 'memberCount',
        options: filterOptions.memberCount,
      }, {
        name: 'UUID',
        property: 'uuid',
        options: filterOptions.uuids,
      }]" @row-click="e => $emit('rowClick', e)"/>
</template>

<script>
import { Skeleton } from '@components/ui/skeleton'
import DataTable from '@components/ui/data-table/DataTable.vue'
import { useServiceClientStore } from '@store/serviceClientStore.js'
import { useGroupStore } from '@store/useGroupStore.js'
import { columns } from './groupListColumns.ts'

export default {
  emits: ['rowClick'],

  setup () {
    return {
      s: useServiceClientStore(),
      g: useGroupStore(),
      columns: columns,
    }
  },

  components: {
    Skeleton,
    DataTable,
  },

  computed: {
    initialSort () {
      return [{
        id: 'name',
        desc: false
      }]
    },
    filterOptions () {
      return {
        names: this.g.data.map((g) => g.name).filter((v, i, a) => a.indexOf(v) === i).map((g) => {
          return {
            label: g,
            value: g,
          }
        }),
        class: this.g.data.map((g) => g.class.name).filter((v, i, a) => a.indexOf(v) === i).map((g) => {
          return {
            label: g,
            value: g,
          }
        }),
        uuids: this.g.data.map((g) => g.uuid).filter((v, i, a) => a.indexOf(v) === i).map((g) => {
          return {
            label: g,
            value: g,
          }
        }),
        memberCount: this.g.data.map((g) => g.members.length).filter((v, i, a) => a.indexOf(v) === i).map((g) => {
          return {
            label: g,
            value: g,
          }
        }),
      }
    },
  },
}
</script>