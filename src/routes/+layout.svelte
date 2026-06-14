<script>
	import ShaderRenderer from '$lib/components/ShaderRenderer.svelte';
	import vertShaderSource from '$lib/shaders/isovalues/vert.glsl?raw';
	import fragShaderSource from '$lib/shaders/isovalues/frag.glsl?raw';
</script>

<ShaderRenderer {vertShaderSource} {fragShaderSource} />

<slot />
