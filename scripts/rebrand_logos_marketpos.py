"""Rebrand POS logo PNGs to MarketPos (keeps icon, redraws text)."""
from PIL import Image, ImageDraw, ImageFont
import os

GREEN = (156, 191, 42, 255)
WHITE = (254, 254, 254, 255)
GRAY = (216, 214, 213, 255)
DARK_GRAY_BG = (61, 61, 61, 255)
ICON_WIDTH = 32
TEXT_X = 36

FONT_CANDIDATES = [
    r"C:\Windows\Fonts\segoeui.ttf",
    r"C:\Windows\Fonts\arial.ttf",
]


def load_font(size, bold=False):
    paths = FONT_CANDIDATES
    if bold:
        paths = [r"C:\Windows\Fonts\segoeuib.ttf", r"C:\Windows\Fonts\arialbd.ttf"] + paths
    for path in paths:
        if os.path.isfile(path):
            return ImageFont.truetype(path, size)
    return ImageFont.load_default()


def clear_text_region(im, bg):
    w, h = im.size
    draw = ImageDraw.Draw(im)
    if bg is None:
        for x in range(ICON_WIDTH, w):
            for y in range(h):
                im.putpixel((x, y), (0, 0, 0, 0))
    else:
        draw.rectangle([ICON_WIDTH, 0, w, h], fill=bg)


def draw_marketpos(im, text_color=WHITE, pos_bold=True, font_size=None, y_offset=0):
    w, h = im.size
    draw = ImageDraw.Draw(im)
    if font_size is None:
        font_size = max(10, int(h * 0.62))

    font_light = load_font(font_size, bold=False)
    font_heavy = load_font(font_size, bold=True) if pos_bold else font_light

    market = "Market"
    pos = "Pos"
    cy = (h - font_size) // 2 + y_offset
    x = TEXT_X

    draw.text((x, cy), market, fill=text_color, font=font_light)
    market_w = draw.textlength(market, font=font_light)
    draw.text((x + market_w, cy), pos, fill=GREEN, font=font_heavy)


def rebrand(path, bg=None, text_color=WHITE, font_size=None):
    if not os.path.isfile(path):
        print(f"Skip missing {path}")
        return
    im = Image.open(path).convert("RGBA")
    clear_text_region(im, bg)
    draw_marketpos(im, text_color=text_color, font_size=font_size)
    if bg is not None and bg[3] == 255:
        flat = Image.new("RGBA", im.size, bg)
        flat.paste(im, mask=im)
        im = flat
    im.save(path)
    print(f"Updated {path} ({im.size[0]}x{im.size[1]})")


def main():
    base = r"c:\Projects\CleverPos\LogicPOS.UI\Assets\Themes\Default\Images"
    rebrand(os.path.join(base, "logo_backoffice.png"), bg=None, text_color=WHITE, font_size=18)
    rebrand(os.path.join(base, "logo_backoffice_long.png"), bg=DARK_GRAY_BG, text_color=GRAY, font_size=16)
    rebrand(os.path.join(base, "logo_pos.png"), bg=None, text_color=GRAY, font_size=22)

    large = os.path.join(base, "logicPOS_logo.png")
    if os.path.isfile(large):
        im = Image.open(large).convert("RGBA")
        w, h = im.size
        for x in range(ICON_WIDTH, w):
            for y in range(h):
                im.putpixel((x, y), (0, 0, 0, 0))
        draw_marketpos(im, text_color=WHITE, font_size=36, y_offset=-2)
        im.save(large)
        print(f"Updated {large} ({w}x{h})")

    extras = [
        r"c:\Projects\CleverPos\LogicPOS.UI\Assets\Images\CleverPos.png",
        r"c:\Projects\CleverPos\LogicPOS.UI\Assets\Images\Icos\CleverPos.png",
        r"c:\Projects\CleverPos\LogicPOS.UI\Assets\Themes\Default\Images\CleverPos_logo.png",
    ]
    for path in extras:
        if os.path.isfile(path):
            rebrand(path, bg=None, text_color=WHITE)


if __name__ == "__main__":
    main()
