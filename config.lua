--===== FiveM Script =========================================
--= DC - Rich Presence
--===== Developed By: ========================================
--= Azael Dev
--===== Website: =============================================
--= https://www.azael.dev
--===== License: =============================================
--= Copyright (C) Azael Dev - All Rights Reserved
--= You are not allowed to sell this script
--============================================================ 

CONFIG = {}

CONFIG.Option = {                                           -- Option
    Update = {                                              -- Update
        Time = 1                                            -- เวลาในการอัพเดทสถานะ (ระบุเป็น “นาที”)
    },

    Display = {                                             -- Display
        ID = {                                              -- ไอดี
            Enable = true                                   -- แสดง ไอดีผู้เล่น (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
        },

        Name = {                                            -- ชื่อ
            Enable = true                                   -- แสดง ชื่อผู้เล่น (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
        },

        Online = {                                          -- ออนไลน์
            Enable = true                                   -- แสดง จำนวนผู้เล่นออนไลน์ (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
        }
    }
}

CONFIG.Discord = {                                          -- Discord
    Application = {                                         -- Application (Developer Portal: https://discord.com/developers/applications)
        ID = 000000000000000000                             -- ID (รูปภาพตัวอย่าง: https://i.imgur.com/cWZjHB3.png)
    },

    Asset = {                                               -- Asset (Art Assets: https://discord.com/developers/applications/YOUR_APP_ID/rich-presence/assets)
        Logo = {                                            -- ภาพสัญลักษณ์ (ขนาดปกติ)
            Name = 'logo-large',                            -- ชื่อ (รูปภาพตัวอย่าง: https://imgur.com/y1Amkyu.png)
            Text = 'AZAEL - BETA SERVER'                    -- ข้อความ
        },

        Icon = {                                            -- ภาพสัญลักษณ์ (ขนาดเล็ก)
            Name = 'logo-small',                            -- ชื่อ (รูปภาพตัวอย่าง: https://i.imgur.com/0STQ7rh.png)
            Text = 'AZAEL - BETA SERVER'                    -- ข้อความ
        }
    },

    Button = {                                              -- Button (ปุ่ม)
        [1] = {                                             -- ปุ่มที่ 1
            Text = 'Join Discord',                          -- ข้อความ
            URL = 'https://discord.gg/invite'               -- URL
        },

        [2] = {                                             -- ปุ่มที่ 2
            Text = 'Join Server',                           -- ข้อความ
            URL = 'fivem://connect/127.0.0.1:30120'         -- URL
        }
    }
}
