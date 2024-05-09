<script lang="ts">
	import { onMount } from 'svelte';
	import { page } from '$app/stores';

	onMount(() => {
		if ($page.status == 404) {
			window.location.href = '/';
		}
	});
</script>

<div>
	<h1>{$page.status}</h1>
	<h2>{$page.error?.message}</h2>
</div>

<style>
	div {
		inset: 0;
		margin: auto;
		position: fixed;
		width: fit-content;
		height: fit-content;
	}

	h1,
	h2 {
		margin: 4px 0;
		color: #f8f8f8;
		text-align: center;
		-webkit-user-select: none;
		-ms-user-select: none;
		user-select: none;
	}
</style>
