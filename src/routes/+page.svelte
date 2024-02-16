<script lang="ts">
	import GlowCard from '$lib/components/GlowCard.svelte';
	import Avatar from '$lib/components/Avatar.svelte';
	import LinksList from '$lib/components/LinksList.svelte';
	import { version } from '$app/environment';
</script>

<GlowCard>
	<Avatar
		round
		src="https://avatars.githubusercontent.com/u/45133474?s=96"
		alt="yobson"
		width={96}
	/>
	<h2>yobson</h2>
	<hr />
	<LinksList
		links={{
			GitHub: 'https://github.com/yobson1',
			Discord: 'https://discord.com/users/280102934111322112',
			Twitch: 'https://www.twitch.tv/yobson',
			YouTube: 'https://www.youtube.com/@yobson',
			Twitter: 'https://twitter.com/yobson8',
			buymeacoffee: 'https://www.buymeacoffee.com/yobson'
		}}
	/>
	<!-- Version tag -->
	<h3 class="version-tag">v{version}</h3>
</GlowCard>

<style>
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

	.version-tag {
		color: #8f8f8f;
		font-size: 12px;
		-webkit-user-select: none;
		-ms-user-select: none;
		user-select: none;
		position: absolute;
		bottom: 0;
		right: 0;
		text-align: right;
		padding-right: 1em;
	}
</style>
