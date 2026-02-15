import webview
import os
import sys
import json

# =========================
# GET FOLDER ARG
# =========================

if len(sys.argv) > 1:

    folder = os.path.abspath(sys.argv[1])

else:

    folder = os.getcwd()


# =========================
# READ FILES
# =========================

def get_files():

    result = {}

    for root, dirs, files in os.walk(folder):

        for name in files:

            full = os.path.join(root, name)

            rel = os.path.relpath(full, folder)

            try:

                with open(full, "r", encoding="utf-8") as f:

                    result[rel.replace("\\","/")] = f.read()

            except:

                pass

    return result


FILES = get_files()


# =========================
# WHEN WEBVIEW READY
# =========================

def loaded():

    js = f"""

    window.KEYCAP_FILES = {json.dumps(FILES)};


    // inject into keycap editor

    function inject(){{

        if(!window.localStorage) return;

        const project = {{

            id: "desktop",

            name: "Desktop Project",

            files: window.KEYCAP_FILES,

            createdAt: Date.now()

        }}

        localStorage.setItem(

            "keycap_projects",

            JSON.stringify([project])

        )

        location.reload()

    }}


    inject()

    """

    webview.windows[0].evaluate_js(js)



# =========================
# START WEBVIEW
# =========================

window = webview.create_window(

    "Keycap Desktop",

    "https://keycapeditor.github.io"

)

webview.start(loaded)
