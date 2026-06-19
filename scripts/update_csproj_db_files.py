import os

csproj = r"c:\Projects\CleverPos\LogicPOS.UI\LogicPOS.UI.csproj"
text = open(csproj, encoding="utf-8").read()

new_files = [
    r"Resources\Database\Data\Default\ru\databasedata.sql",
    r"Resources\Database\Data\BackOfficeMode\ru\databasedata.sql",
    r"Resources\Database\Data\ru\databasedata.sql",
    r"Resources\Database\Demos\Bakery\ru\databasedatademo_bakery.sql",
    r"Resources\Database\Demos\Butchery\ru\databasedatademo_butchery.sql",
    r"Resources\Database\Demos\Cafe\ru\databasedatademo_cafe.sql",
    r"Resources\Database\Demos\ClothingStore\ru\databasedatademo_clothing_store.sql",
    r"Resources\Database\Demos\HardwareStore\ru\databasedatademo_hardware_store.sql",
    r"Resources\Database\Demos\Parking\ru\databasedatademo_parking.sql",
    r"Resources\Database\Demos\Restaurant\ru\databasedatademo_restaurant.sql",
    r"Resources\Database\Demos\SeafoodShop\ru\databasedatademo_seafood_shop.sql",
    r"Resources\Database\Demos\ShoeStore\ru\databasedatademo_shoe_store.sql",
    r"Resources\Database\Other\Country\KZ\configurationcurrency.sql",
    r"Resources\Database\Other\Country\KZ\configurationholidays.sql",
    r"Resources\Database\Other\Country\KZ\configurationprinters.sql",
    r"Resources\Database\Other\Country\KZ\configurationvatrate.sql",
    r"Resources\Database\Other\Country\KZ\customer.sql",
]

blocks = []
for f in new_files:
    if f in text:
        print("exists", f)
        continue
    blocks.append(
        f'    <Content Include="{f}">\n'
        f"      <CopyToOutputDirectory>Always</CopyToOutputDirectory>\n"
        f"    </Content>"
    )
    print("add", f)

if blocks:
    insert = "\n".join(blocks) + "\n"
    marker = '    <Content Include="Resources\\Database\\Other\\Country\\notes.txt" />'
    text = text.replace(marker, insert + marker)
    open(csproj, "w", encoding="utf-8", newline="\n").write(text)
    print("csproj updated", len(blocks))
