<script lang="ts">
	import GlowCard from '../components/GlowCard.svelte';
	import Avatar from '../components/Avatar.svelte';
	import LinksList from '../components/LinksList.svelte';
</script>

<GlowCard>
	<Avatar round src="https://avatars.githubusercontent.com/u/45133474" alt="yobson" />
	<h2>yobson</h2>
	<hr />
	<LinksList
		links={{
			GitHub: 'https://github.com/yobson1',
			Discord: 'https://discord.com/users/280102934111322112',
			Twitch: 'https://www.twitch.tv/yobson',
			YouTube: 'https://www.youtube.com/@yobson'
		}}
	/>
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
</style>
