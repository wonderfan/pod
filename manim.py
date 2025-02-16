from manim import *
from manim_voiceover import VoiceoverScene
from manim_voiceover.services.gtts import GTTSService

class MyManim(VoiceoverScene):
    def construct(self):
        self.set_speech_service(GTTSService(lang="en", tld="com"))

        # The paragraph content broken into lines
        lines = [
            "In the game on February 12, 2025, at Madison Square Garden,",
            "which went into overtime with the Knicks winning 149-148,",
            "there was a critical moment in the last seconds of regulation.",
            "With the Knicks leading, Towns attempted an inbounds pass to Bridges,",
            "but the pass was intercepted or mishandled, leading to a turnover.",
            "This blunder gave the Hawks a chance to tie the game,",
            "which they did, forcing overtime."
        ]


        # Create Text objects for each line
        text_mobs = VGroup(*[Text(line, font="Arial", font_size=24) for line in lines])
        
        # Arrange the lines vertically with more space between them
        text_mobs.arrange(DOWN, aligned_edge=LEFT, buff=0.45)
        text_mobs.move_to(ORIGIN)  # Center the text


        # Animate each line with a delay
        for i, text in enumerate(text_mobs):
            if i > 0:
                self.play(Wait(0.2))  # Add a smaller delay before showing the next line
            with self.voiceover(text=lines[i]) as tracker:
                self.play(Write(text, run_time=tracker.duration))


        # Keep the animation going for a bit longer before closing
        self.wait(3)