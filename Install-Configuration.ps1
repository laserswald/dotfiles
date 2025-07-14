# Configure a Windows machine automagically.

$BasePackages = @(
    'Mozilla.Firefox',
    'Obsidian.Obsidian', 
    'SyncTrayzor.SyncTrayzor',
    'Microsoft.PowerToys',
    'Yubico.YubikeyManager',
    'IJHack.QtPass',
    'Telegram.TelegramDesktop',
    'Discord.Discord',

    # Programming tools
    'GNU.Emacs',
    'Git.Git',
    'VSCodium.VSCodium',
    'Racket.Racket',
    'Azul.Zulu.19.JDK',

    'CPUID.CPU-Z'
)

$GamingPackages = @(
    'Valve.Steam',
    'GOG.Galaxy',
    'PrismLauncher.PrismLauncher',

    'OBSProject.OBSStudio',

    'OpenShot.OpenShot',
    'Blender.Blender'
)

function Install-PackageSet {
    foreach $app in $args[0] {
	winget install $app
    }
}

# Use raphire/win11debloat to clean the machine from GARBAGE
& ([scriptblock]::Create((irm "https://debloat.raphi.re/")))

Install-PackageSet $BasePackages



if ($env:COMPUTERNAME -eq "gargantua") {
    Install-PackageSet $GamingPackages
}
