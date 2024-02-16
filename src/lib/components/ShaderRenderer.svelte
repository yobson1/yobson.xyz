<script lang="ts">
	import { onMount } from 'svelte';

	export let vertShaderSource: string;
	export let fragShaderSource: string;

	let container: HTMLElement;
	const firstChild = (el: HTMLElement) => {
		container = el.firstChild as HTMLElement;
	};

	// Shader program
	let shaderProgram: WebGLProgram | null;
	let positionAttributeLocation: number;
	let resolutionUniformLocation: WebGLUniformLocation;
	let timeUniformLocation: WebGLUniformLocation;
	let vertexBuffer: WebGLBuffer;

	// WebGL context
	let gl: WebGLRenderingContext;

	function init() {
		// Create canvas
		const canvas = document.createElement('canvas');
		container.appendChild(canvas);

		// Get WebGL context
		let ctx = canvas.getContext('webgl');
		if (!ctx) {
			console.error('WebGL not supported');
			return;
		}

		gl = ctx;

		// Enable extensions
		gl.getExtension('OES_standard_derivatives');
		gl.getExtension('EXT_shader_texture_lod');

		// Set canvas & viewport size
		canvas.width = container.offsetWidth;
		canvas.height = container.offsetHeight;
		gl.viewport(0, 0, canvas.width, canvas.height);

		// Create shader program
		const vertShader = createShader(gl, gl.VERTEX_SHADER, vertShaderSource);
		const fragShader = createShader(gl, gl.FRAGMENT_SHADER, fragShaderSource);

		if (!vertShader || !fragShader) {
			console.error('Shader not created');
			return;
		}

		shaderProgram = createProgram(gl, vertShader, fragShader);

		if (!shaderProgram) {
			console.error('Shader program not created');
			return;
		}

		// Get attribute and uniform locations
		positionAttributeLocation = gl.getAttribLocation(shaderProgram, 'position');
		resolutionUniformLocation = gl.getUniformLocation(shaderProgram, 'u_resolution')!;
		timeUniformLocation = gl.getUniformLocation(shaderProgram, 'u_time')!;

		// Create vertex buffer
		vertexBuffer = gl.createBuffer()!;
		gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
		const vertices = [-1.0, -1.0, 1.0, -1.0, -1.0, 1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
		gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);

		// Observer the container resize event
		new ResizeObserver(onElementResized).observe(container);

		// Start animation loop
		animate(performance.now());
	}

	// A hack to get around the fact that ResizeObserver callbacks run after rAF
	// We render in the ResizeObserver callback to avoid the flicker and we don't want to call it twice
	// https://github.com/w3c/csswg-drafts/issues/9717
	let didResize: boolean = false;

	function animate(timestamp: number) {
		if (!didResize) render(timestamp / 1000);
		requestAnimationFrame(animate);
		didResize = false;
	}

	function render(time: number) {
		// Clear canvas
		gl.clearColor(0, 0, 0, 1);
		gl.clear(gl.COLOR_BUFFER_BIT);

		// Use shader program
		gl.useProgram(shaderProgram);

		// Set resolution uniform
		gl.uniform2f(
			resolutionUniformLocation,
			gl.canvas.width * window.devicePixelRatio,
			gl.canvas.height * window.devicePixelRatio
		);
		gl.viewport(0, 0, gl.canvas.width, gl.canvas.height);

		// Set time uniform
		gl.uniform1f(timeUniformLocation, time);

		// Bind vertex buffer and attribute
		gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
		gl.enableVertexAttribArray(positionAttributeLocation);
		gl.vertexAttribPointer(positionAttributeLocation, 2, gl.FLOAT, false, 0, 0);

		// Draw triangles
		gl.drawArrays(gl.TRIANGLES, 0, 6);
	}

	// Helper functions
	function createShader(gl: WebGLRenderingContext, type: number, source: string) {
		const shader = gl.createShader(type)!;
		gl.shaderSource(shader, source);
		gl.compileShader(shader);
		if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
			console.error('Shader compilation error:', gl.getShaderInfoLog(shader));
			gl.deleteShader(shader);
			return null;
		}
		return shader;
	}

	function createProgram(
		gl: WebGLRenderingContext,
		vertexShader: WebGLShader,
		fragmentShader: WebGLShader
	) {
		const program = gl.createProgram()!;
		gl.attachShader(program, vertexShader);
		gl.attachShader(program, fragmentShader);
		gl.linkProgram(program);
		if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
			console.error('Program linking error:', gl.getProgramInfoLog(program));
			gl.deleteProgram(program);
			return null;
		}
		return program;
	}

	function onElementResized(resizes: ResizeObserverEntry[]) {
		didResize = true;
		const resize = resizes[0];
		const element = resize.target as HTMLElement;

		// Update the renderer
		gl.canvas.width = element.offsetWidth;
		gl.canvas.height = element.offsetHeight;

		render(performance.now() / 1000);
	}

	onMount(init);
</script>

<div use:firstChild>
	<slot />
</div>
