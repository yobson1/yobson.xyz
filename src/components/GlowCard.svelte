<script lang="ts">
	import Avatar from './Avatar.svelte';
	import { onMount } from 'svelte';
	export let name = 'Name';

	let links = {
		GitHub: 'https://github.com/yobson1',
		Discord: 'https://discord.com/users/280102934111322112',
		Twitch: 'https://www.twitch.tv/yobson',
		YouTube: 'https://www.youtube.com/@yobson'
	};

	let currentIndex = 0; // Tracks the currently focused link
	onMount(() => {
		// Move selection with arrow keys
		const linkElements = document.querySelectorAll('ul li a') as NodeListOf<HTMLAnchorElement>;
		linkElements[currentIndex].focus();
		window.addEventListener('keydown', (event) => {
			if (event.key === 'ArrowDown') {
				currentIndex = (currentIndex + 1) % linkElements.length;
				linkElements[currentIndex].focus();
			} else if (event.key === 'ArrowUp') {
				currentIndex = (currentIndex - 1 + linkElements.length) % linkElements.length;
				linkElements[currentIndex].focus();
			}
		});
	});
</script>

<div class="glow-card">
	<Avatar round src="https://avatars.githubusercontent.com/u/45133474" alt={name} />
	<h2>{name}</h2>
	<hr />
	<ul>
		{#each Object.entries(links) as [name, href]}
			<li>
				<a {href} target="_blank">{name}</a>
			</li>
		{/each}
	</ul>
</div>

<style>
	* {
		font-family: 'Workbench', sans-serif;
		font-optical-sizing: auto;
		font-weight: 400;
		font-style: normal;
		font-variation-settings:
			'BLED' 0,
			'SCAN' 0;
	}

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

	h2 {
		margin: 4px 0;
		color: #f8f8f8;
		font-size: 24px;
		-webkit-user-select: none;
		-ms-user-select: none;
		user-select: none;
		text-align: center;
	}

	hr {
		margin: 8px auto;
		width: 80%;
		height: 2px;
		background-color: #8f8f8f;
		border: none;
		border-radius: 4px;
		box-shadow: 0 0 4px #8f8f8f;
	}

	ul {
		list-style: none;
		padding: 0;
		margin: 0;
	}

	li {
		margin: 4px 0;
	}

	.glow-card {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		width: 16px;
		max-width: 280px;
		height: 0px;
		max-height: 450px;
		background-color: #1d1d1d;
		border: 2px solid #ffffff;
		border-radius: 16px;
		box-shadow: 0 0 8px #ffffff;
		overflow: hidden;
		animation: grow 2s ease-in-out forwards;
		animation-delay: 0.5s;
		text-align: center;
	}

	@keyframes grow {
		12.5% {
			height: 0;
		}
		50% {
			width: 65%;
		}
		100% {
			width: 65%;
			height: 75%;
			filter: drop-shadow(30px 15px 4px rgba(15, 15, 15, 0.75));
		}
	}
</style>
