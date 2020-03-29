const Discord = require("discord.js")
const client = new Discord.Client()
const fs = require('fs');

client.on("ready", () => {
    console.log(`Logged in as ${client.user.tag} for core 1.29++!`)
})
client.on("message", msg => {
    if (msg.content === 'core' && msg.author.id == '204189339285061632') {
        const coreFolder = 'core/';
        fs.readdirSync(coreFolder).forEach(file => {
            const id = file.substring(4, file.length - 4)
            const channelName = `ticket-${id}`
            const fileName = `core${id}.swf`
            const channel = client.channels.cache.find(x => x.name == channelName)
            if (channel && channel.parentID != '649672006177914910') {
                try {
                    client.channels.cache.get(channel.id).send('Une mise à jour du core est disponible !', { files: [coreFolder + fileName] })
                    console.log(`-   ${fileName} sent in ${channelName}`)
                } catch ($err) {
                    console.log(`Can't send ${fileName} in ${channelName}`)
                }
            }
        });
        console.log(`OK.`)
    }
})
client.login("NjkzNTM2MTAyNDY3ODk1NDI4.Xn-hng.M8TMvwjb_wvs1b_bWydBcTWq-fw")