<script>
	import ShaderRenderer from '../components/ShaderRenderer.svelte';
	import vertShader from '../shaders/isovalues/vert.glsl?raw';
	import fragShader from '../shaders/isovalues/frag.glsl?raw';
</script>

<ShaderRenderer {vertShader} {fragShader}>
	<div slot="shader-container" class="background-shader" />
</ShaderRenderer>

<style>
	.background-shader {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
	}
</style>
