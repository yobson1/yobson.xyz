<script>
	export let src = '';
	export let alt = 'Avatar';
	export let round = false;
	export let width = 100;
	export let height = width;
</script>

<img {src} {alt} {width} {height} style="--width: {width}px" class:round />

<style>
	img {
		margin-top: 12px;
		width: var(--width);
		position: relative;
		border: 2px solid #8f8f8f;
	}

	.round {
		border-radius: 50%;
	}
</style>
