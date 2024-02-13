<script lang="ts">
	import * as THREE from 'three';
	import { onMount } from 'svelte';

	export let vertShader: string;
	export let fragShader: string;

	let container: HTMLElement;
	const firstChild = (el: HTMLElement) => {
		container = el.firstChild as HTMLElement;
	};

	let renderer: THREE.WebGLRenderer, scene: THREE.Scene, camera: THREE.OrthographicCamera;
	let uniforms: Record<string, THREE.IUniform> = {};

	async function init() {
		// Initialize the renderer
		renderer = new THREE.WebGLRenderer();
		renderer.setPixelRatio(window.devicePixelRatio);

		// Add the renderer to our container
		container.appendChild(renderer.domElement);

		// Size the renderer to the container
		renderer.setSize(container.offsetWidth, container.offsetHeight);

		// Initialize the scene
		scene = new THREE.Scene();
		camera = new THREE.OrthographicCamera(-1, 1, 1, -1, 0, 1);
		const geometry = new THREE.PlaneGeometry(2, 2);

		// Define the shader uniforms
		uniforms = {
			u_time: { value: 0 },
			u_resolution: {
				value: new THREE.Vector2(container.offsetWidth, container.offsetHeight).multiplyScalar(
					window.devicePixelRatio
				)
			}
		};

		// Create the shader material
		const material = new THREE.ShaderMaterial({
			uniforms: uniforms,
			vertexShader: vertShader,
			fragmentShader: fragShader
		});

		// Create the mesh and add it to the scene
		const mesh = new THREE.Mesh(geometry, material);
		scene.add(mesh);

		// Observer the container resize event
		new ResizeObserver(onElementResized).observe(container);
		animate(0);
	}

	// A hack to get around the fact that ResizeObserver callbacks run after rAF
	// We render in the ResizeObserver callback to avoid the flicker and we don't want to call it twice
	// https://github.com/w3c/csswg-drafts/issues/9717
	let didResize: boolean = false;

	function render(timestamp: number) {
		uniforms.u_time.value = timestamp / 1000;
		renderer.render(scene, camera);
	}

	function animate(timestamp: number) {
		if (!didResize) render(timestamp);
		requestAnimationFrame(animate);
		didResize = false;
	}

	// Updates the renderer size and the uniforms when the window is resized
	function onElementResized(resizes: ResizeObserverEntry[]) {
		didResize = true;
		const resize = resizes[0];
		const element = resize.target as HTMLElement;

		// Update the renderer
		renderer.setSize(element.offsetWidth, element.offsetHeight);

		// Update the resolution uniform
		uniforms.u_resolution.value
			.set(element.offsetWidth, element.offsetHeight)
			.multiplyScalar(window.devicePixelRatio);

		render(performance.now());
	}

	onMount(init);
</script>

<div use:firstChild>
	<slot name="shader-container" />
</div>
