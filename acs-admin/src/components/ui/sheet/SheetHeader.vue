<!--
  - Copyright (c) University of Sheffield AMRC 2024.
  -->

<script setup>
import { cn } from '@/lib/utils'

const props = defineProps({
  class: { type: null, required: false },
});
</script>

<template>
  <div
    :class="cn('flex flex-col text-center sm:text-left', props.class)"
  >
    <slot />
  </div>
</template>
