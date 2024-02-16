<script lang="ts">
	import { onMount } from 'svelte';
	export let links: Record<string, string> = {};

	let currentIndex = 0; // Tracks the currently focused link
	onMount(() => {
		// Move selection with arrow keys
		const linkElements = Array.from(document.querySelectorAll<HTMLAnchorElement>('ul li a'));
		linkElements[currentIndex].focus();

		// Helper functions
		function isFocusedElementOurLink() {
			const focusedElement = document.activeElement;
			return (
				focusedElement &&
				focusedElement instanceof HTMLAnchorElement &&
				linkElements.includes(focusedElement)
			);
		}

		function moveIndex(direction: number) {
			return (currentIndex + direction + linkElements.length) % linkElements.length;
		}

		function focusCurrentIndex() {
			const curLink = linkElements[currentIndex];
			if (curLink && curLink != document.activeElement) curLink.focus();
		}

		window.addEventListener('keydown', (event) => {
			if (!isFocusedElementOurLink()) return;

			if (event.key === 'ArrowDown' || event.key === 'ArrowRight' || event.key === 'Tab') {
				event.preventDefault();
				currentIndex = moveIndex(1);
			} else if (event.key === 'ArrowUp' || event.key === 'ArrowLeft') {
				currentIndex = moveIndex(-1);
			} else if (event.key === 'Home') {
				currentIndex = 0;
			} else if (event.key === 'End') {
				currentIndex = linkElements.length - 1;
			}

			// Focus the next link that starts with the key we pressed
			for (let i = 1; i <= linkElements.length; i++) {
				const indexToCheck = (currentIndex + i) % linkElements.length;
				const link = linkElements[indexToCheck];
				if (
					event.key.length == 1 &&
					link.textContent?.toLowerCase().startsWith(event.key.toLowerCase())
				) {
					currentIndex = indexToCheck;
					break;
				}
			}

			focusCurrentIndex();
		});

		window.addEventListener('wheel', (event) => {
			if (!isFocusedElementOurLink()) return;

			if (event.deltaY > 0) {
				currentIndex = moveIndex(1);
			} else if (event.deltaY < 0) {
				currentIndex = moveIndex(-1);
			}

			focusCurrentIndex();
		});

		window.addEventListener('focusin', (event) => {
			if (event.target instanceof HTMLAnchorElement && linkElements.includes(event.target)) {
				currentIndex = linkElements.indexOf(event.target);
			} else {
				currentIndex = 0;
			}
		});

		// Disable focus loss when clicking away
		window.addEventListener('pointerdown', (event) => {
			event.preventDefault();
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
