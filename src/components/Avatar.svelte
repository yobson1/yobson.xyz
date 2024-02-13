<script>
	export let src = '';
	export let alt = 'Avatar';
	export let round = false;
</script>

<img {src} {alt} class:round />

<style>
	img {
		margin-top: 12px;
		width: 100px;
		position: relative;
		border: 2px solid #8f8f8f;
	}

	.round {
		border-radius: 50%;
	}
</style>
