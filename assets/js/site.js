document.addEventListener("DOMContentLoaded", () => {
  const body = document.body;
  const titleHeader = document.querySelector("#title-block-header");
  const toc = document.querySelector("nav#TOC");

  if (!titleHeader) {
    return;
  }

  initializeTheme(body);
  ensureProgressBar();
  const topbar = ensureTopbar(titleHeader);
  const layout = ensureLayout(body, titleHeader, toc);

  if (!layout) {
    return;
  }

  const { sidebar, content, article } = layout;
  enhanceHero(titleHeader);
  buildSidebar(toc, article, sidebar);
  installSidebarToggle(topbar, body);
  installThemeToggle(topbar, body);
  installCopyButtons(article);
  installScrollProgress();
  installActiveToc(article);
});

function initializeTheme(body) {
  const storedTheme = localStorage.getItem("python-book-theme");
  if (storedTheme === "dark") {
    body.classList.add("dark");
  }
}

function ensureProgressBar() {
  if (document.querySelector(".progress-bar")) {
    return;
  }

  const progressBar = document.createElement("div");
  progressBar.className = "progress-bar";
  document.body.prepend(progressBar);
}

function ensureTopbar(titleHeader) {
  let topbar = document.querySelector(".site-topbar");
  if (topbar) {
    return topbar;
  }

  const titleText = titleHeader.querySelector(".title")?.textContent?.trim() || "Python 程式設計入門";
  const authorText = titleHeader.querySelector(".author")?.textContent?.trim() || "J5";

  topbar = document.createElement("div");
  topbar.className = "site-topbar";
  topbar.innerHTML = `
    <div class="site-brand">
      <div class="site-brand-badge">Py</div>
      <div class="site-brand-text">
        <strong>${escapeHtml(titleText)}</strong>
        <span>${escapeHtml(authorText)}｜Python 初學者電子書</span>
      </div>
    </div>
    <div class="site-topbar-actions">
      <button class="site-btn" type="button" data-role="menu" aria-expanded="false">目錄</button>
      <button class="site-btn" type="button" data-role="theme">深色</button>
    </div>
  `;

  document.body.prepend(topbar);
  return topbar;
}

function ensureLayout(body, titleHeader, toc) {
  if (document.querySelector(".site-layout")) {
    const sidebar = document.querySelector(".site-sidebar");
    const content = document.querySelector(".site-main");
    const article = document.querySelector(".book-article");

    return sidebar && content && article ? { sidebar, content, article } : null;
  }

  const layout = document.createElement("div");
  layout.className = "site-layout";
  const movableNodes = [];
  let cursor = titleHeader.nextSibling;

  while (cursor) {
    const next = cursor.nextSibling;

    if (cursor !== toc) {
      movableNodes.push(cursor);
    }

    cursor = next;
  }

  const sidebar = document.createElement("aside");
  sidebar.className = "site-sidebar";

  const sidebarPanel = document.createElement("div");
  sidebarPanel.className = "site-sidebar-panel";
  sidebar.append(sidebarPanel);

  if (toc) {
    sidebarPanel.append(toc);
  }

  const sidebarCard = document.createElement("div");
  sidebarCard.className = "sidebar-card";
  sidebarCard.innerHTML = `
    <strong>閱讀提示</strong>
    <p>建議依章節順序閱讀，每章都先看例子，再動手修改程式。</p>
  `;
  sidebar.append(sidebarCard);

  const main = document.createElement("main");
  main.className = "site-main";

  titleHeader.classList.add("site-hero");
  main.append(titleHeader);

  const article = document.createElement("article");
  article.className = "book-article";

  movableNodes.forEach((node) => article.append(node));

  main.append(article);
  layout.append(sidebar, main);
  body.append(layout);

  return { sidebar, content: main, article };
}

function enhanceHero(titleHeader) {
  titleHeader.removeAttribute("style");
}

function buildSidebar(toc, article, sidebar) {
  if (!toc || !article || !sidebar) {
    return;
  }

  const chapterHeadings = Array.from(article.children)
    .filter((node) => node.tagName === "H1" && node.id)
    .filter((heading, index) => {
      if (index !== 0) {
        return true;
      }

      const pageTitle = document.querySelector(".title")?.textContent?.trim();
      return heading.textContent.trim() !== pageTitle;
    });

  const fallbackLinks = Array.from(toc.querySelectorAll(":scope > ul > li > a"));
  const items = chapterHeadings.length
    ? chapterHeadings.map((heading) => ({ href: `#${heading.id}`, label: heading.textContent.trim() }))
    : fallbackLinks
        .map((link) => ({ href: link.getAttribute("href"), label: link.textContent.trim() }))
        .filter((item) => item.href && item.label);

  const list = document.createElement("ul");
  list.className = "toc";

  items.forEach((item) => {
    const li = document.createElement("li");
    const link = document.createElement("a");
    link.href = item.href;
    link.textContent = item.label;
    li.append(link);
    list.append(li);
  });

  toc.innerHTML = "";
  const heading = document.createElement("h2");
  heading.textContent = "目錄";
  heading.style.display = "none";
  toc.append(heading, list);
}

function installSidebarToggle(topbar, body) {
  const menuButton = topbar.querySelector('[data-role="menu"]');
  if (!menuButton) {
    return;
  }

  menuButton.addEventListener("click", () => {
    const isOpen = body.classList.toggle("sidebar-open");
    menuButton.setAttribute("aria-expanded", String(isOpen));
  });

  document.addEventListener("click", (event) => {
    if (window.innerWidth > 980 || !body.classList.contains("sidebar-open")) {
      return;
    }

    const target = event.target;
    const sidebar = document.querySelector(".site-sidebar");

    if (!(target instanceof Node) || !sidebar) {
      return;
    }

    if (!sidebar.contains(target) && !menuButton.contains(target)) {
      body.classList.remove("sidebar-open");
      menuButton.setAttribute("aria-expanded", "false");
    }
  });
}

function installThemeToggle(topbar, body) {
  const themeButton = topbar.querySelector('[data-role="theme"]');
  if (!themeButton) {
    return;
  }

  const syncLabel = () => {
    themeButton.textContent = body.classList.contains("dark") ? "淺色" : "深色";
  };

  syncLabel();

  themeButton.addEventListener("click", () => {
    const isDark = body.classList.toggle("dark");
    localStorage.setItem("python-book-theme", isDark ? "dark" : "light");
    syncLabel();
  });
}

function installCopyButtons(article) {
  const blocks = article.querySelectorAll("pre, div.sourceCode");

  blocks.forEach((block) => {
    if (block.querySelector(".copy-code")) {
      return;
    }

    const source = block.matches("pre") ? block.innerText : block.querySelector("pre")?.innerText;

    if (!source) {
      return;
    }

    const button = document.createElement("button");
    button.className = "copy-code";
    button.type = "button";
    button.textContent = "複製";

    button.addEventListener("click", async () => {
      try {
        await navigator.clipboard.writeText(source.trim());
        button.textContent = "已複製";
        window.setTimeout(() => {
          button.textContent = "複製";
        }, 1200);
      } catch (error) {
        button.textContent = "失敗";
        window.setTimeout(() => {
          button.textContent = "複製";
        }, 1200);
      }
    });

    block.prepend(button);
  });
}

function installScrollProgress() {
  const progressBar = document.querySelector(".progress-bar");
  if (!progressBar) {
    return;
  }

  const update = () => {
    const scrollTop = window.scrollY;
    const scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
    const progress = scrollHeight > 0 ? (scrollTop / scrollHeight) * 100 : 0;
    progressBar.style.width = `${Math.max(0, Math.min(100, progress))}%`;
  };

  update();
  document.addEventListener("scroll", update, { passive: true });
  window.addEventListener("resize", update);
}

function installActiveToc(article) {
  const links = Array.from(document.querySelectorAll("nav#TOC .toc a"));
  if (!links.length) {
    return;
  }

  const headings = links
    .map((link) => {
      const id = link.getAttribute("href")?.slice(1);
      return id ? article.querySelector(`#${CSS.escape(id)}`) : null;
    })
    .filter(Boolean);

  const setActive = (id) => {
    links.forEach((link) => {
      const active = link.getAttribute("href") === `#${id}`;
      link.classList.toggle("active", active);
    });
  };

  if ("IntersectionObserver" in window && headings.length) {
    const observer = new IntersectionObserver(
      (entries) => {
        const visible = entries
          .filter((entry) => entry.isIntersecting)
          .sort((a, b) => a.boundingClientRect.top - b.boundingClientRect.top)[0];

        if (visible?.target?.id) {
          setActive(visible.target.id);
        }
      },
      { rootMargin: "-20% 0px -65% 0px", threshold: [0, 1] }
    );

    headings.forEach((heading) => observer.observe(heading));
  } else if (headings[0]?.id) {
    setActive(headings[0].id);
  }
}

function escapeHtml(value) {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");
}
