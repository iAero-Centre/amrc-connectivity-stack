<!--
  - Copyright (c) University of Sheffield AMRC 2025.
  -->

<script setup>
import { TooltipTrigger } from 'reka-ui'

const props = defineProps({
  asChild: { type: Boolean, required: false },
  as: { type: null, required: false },
});
</script>

<template>
  <TooltipTrigger v-bind="props">
    <slot />
  </TooltipTrigger>
</template>
