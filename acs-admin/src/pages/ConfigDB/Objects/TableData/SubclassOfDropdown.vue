<!--
  - Copyright (c) University of Sheffield AMRC 2024.
  -->

<script setup lang="ts">
import type {Row} from '@tanstack/vue-table'
import type {SubclassOfMapping} from './objectSubclassOfListColumns'
import {Button} from '@/components/ui/button'
import {DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuSeparator, DropdownMenuTrigger, DropdownMenuGroup} from '@/components/ui/dropdown-menu'
import {toast} from "vue-sonner";
import {useDialog} from '@/composables/useDialog';
import {useServiceClientStore} from '@store/serviceClientStore.js'

interface DataTableRowActionsProps {
    row: Row<SubclassOfMapping>
}

const s = useServiceClientStore()
const cdb = s.client.ConfigDB

const props = defineProps<DataTableRowActionsProps>()

function copy(id: string) {
    navigator.clipboard.writeText(id)
    toast.success('UUID copied to clipboard')
}

function handleDelete() {
  useDialog({
    title: 'Remove Classification?',
    message: `Are you sure you want to remove the classification of ${props.row.original.name}`,
    confirmText: 'Remove',
    onConfirm: async () => {
      try {
        await cdb.class_remove_subclass(props.row.original.uuid, props.row.original.originalObject.uuid)
        toast.success(`Classification of ${props.row.original.name} has been removed`)
      } catch (err) {
        toast.error(`Unable to remove classification of ${props.row.original.name}`)
      }
    }
  });
}

</script>

<template>
  <DropdownMenu>
    <div @click.stop>
      <DropdownMenuTrigger as-child>
        <Button
            variant="ghost"
            class="flex h-8 w-8 p-0 data-[state=open]:bg-muted"
        >
          <i class="fa-solid fa-ellipsis"></i>
          <span class="sr-only">Open menu</span>
        </Button>
      </DropdownMenuTrigger>
    </div>
    <DropdownMenuContent align="end" class="w-[250px]">
      <DropdownMenuGroup>
        <DropdownMenuItem @click="copy(props.row.original.uuid)" class="cursor-pointer">
          <div class="flex items-center justify-center gap-2">
            <i class="fa-solid fa-fw fa-tag"></i>
            Copy Object UUID
          </div>
        </DropdownMenuItem>
      </DropdownMenuGroup>
      <DropdownMenuGroup>
        <DropdownMenuItem @click="copy(props.row.original.class.uuid)" class="cursor-pointer">
          <div class="flex items-center justify-center gap-2">
            <i class="fa-solid fa-fw fa-tag"></i>
            Copy Class UUID
          </div>
        </DropdownMenuItem>
      </DropdownMenuGroup>
      <DropdownMenuSeparator/>
      <DropdownMenuGroup>
        <DropdownMenuItem @click="handleDelete" class="cursor-pointer">
          <div class="flex items-center justify-center gap-2">
            <i class="fa-solid fa-fw fa-trash text-red-500"></i>
            Remove Classification
          </div>
        </DropdownMenuItem>
      </DropdownMenuGroup>
    </DropdownMenuContent>
  </DropdownMenu>
</template>
