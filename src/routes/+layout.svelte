<script>
	import ShaderRenderer from '$lib/components/ShaderRenderer.svelte';
	import vertShaderSource from '$lib/shaders/isovalues/vert.glsl?raw';
	import fragShaderSource from '$lib/shaders/isovalues/frag.glsl?raw';
</script>

<ShaderRenderer {vertShaderSource} {fragShaderSource}>
	<div class="background-shader" />
</ShaderRenderer>

<slot />

<style>
	.background-shader {
		position: fixed;
		top: 0;
		left: 0;
		margin: 0;
		padding: 0;
		width: 100%;
		height: 100%;
		z-index: -1;
	}
</style>
