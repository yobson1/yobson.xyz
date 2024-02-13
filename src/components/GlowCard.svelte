<div class="glow-card">
	<slot />
</div>

<style>
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
