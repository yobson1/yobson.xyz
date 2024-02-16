<script lang="ts">
	import { onMount } from 'svelte';
	export let links: Record<string, string> = {};

	let currentIndex = 0; // Tracks the currently focused link
	onMount(() => {
		// Move selection with arrow keys
		const linkElements = Array.from(document.querySelectorAll<HTMLAnchorElement>('ul li a'));
		linkElements[currentIndex].focus();
		window.addEventListener('keydown', (event) => {
			if (event.key === 'ArrowDown' || event.key === 'ArrowRight' || event.key === 'Tab') {
				event.preventDefault();
				currentIndex = (currentIndex + 1) % linkElements.length;
				linkElements[currentIndex].focus();
			} else if (event.key === 'ArrowUp' || event.key === 'ArrowLeft') {
				currentIndex = (currentIndex - 1 + linkElements.length) % linkElements.length;
				linkElements[currentIndex].focus();
			}
		});

		window.addEventListener('focusin', (event) => {
			if (event.target instanceof HTMLAnchorElement) {
				currentIndex = linkElements.indexOf(event.target);
			}
		});
	});
</script>

<ul>
	{#each Object.entries(links) as [name, href]}
		<li>
			<a {href} target="_blank">{name}</a>
		</li>
	{/each}
</ul>

<style>
	a {
		text-decoration: none;
		color: #f8f8f8;
	}

	a:hover,
	a:focus {
		background-color: #f8f8f8;
		color: #1d1d1d;
		outline: none;
	}

	a:hover::before,
	a:focus::before {
		content: '> ';
		animation: blink 1.2s infinite;
	}

	@keyframes blink {
		0% {
			opacity: 0;
		}
		50% {
			opacity: 1;
		}
		100% {
			opacity: 0;
		}
	}

	ul {
		list-style: none;
		padding: 0;
		margin: 0;
	}

	li {
		margin: 4px 0;
	}
</style>