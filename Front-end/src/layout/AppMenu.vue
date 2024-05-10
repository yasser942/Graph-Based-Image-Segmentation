<script setup>
import { ref } from 'vue';

import AppMenuItem from './AppMenuItem.vue';

const model = ref([
    {
        //label: 'Home',
        items: [
          { label: 'Image Segmenter', icon: 'pi pi-fw pi-image', to: '/' },
        ]
    },

]);
</script>

<template>
    <ul class="layout-menu">
      <li>
        <a  >
          <img src="/layout/images/Image viewer-rafiki.png" alt="Prime Blocks" class="w-full mt-3" />
        </a>
      </li>
        <template v-for="(item, i) in model" :key="item">
            <app-menu-item v-if="!item.separator" :item="item" :index="i"></app-menu-item>
            <li v-if="item.separator" class="menu-separator"></li>
        </template>

    </ul>
</template>

<style lang="scss" scoped></style>
