<script>
	import '../app.css';

	import ShaderRenderer from '../components/ShaderRenderer.svelte';
	import vertShaderSource from '../shaders/isovalues/vert.glsl?raw';
	import fragShaderSource from '../shaders/isovalues/frag.glsl?raw';
</script>

<ShaderRenderer {vertShaderSource} {fragShaderSource}>
	<div class="background-shader" />
</ShaderRenderer>

<slot />

<style>
	.background-shader {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		z-index: -1;
	}
</style>
