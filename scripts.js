// scripts.js - interactivity for Random Adventure Generator

/*
Features:
- Screen navigation (home, saved, categories)
- Generate random adventures (optionally by category)
- Save / unsave adventures to localStorage
- Render saved list
*/

(() => {
  const NAV_KEY = 'rag_saved_adventures_v1';

  // Simple adventure pool (expandable). Will be replaced by server data if available.
  let ADVENTURES = [
    { text: 'Try a new restaurant within 5 miles', categories: ['Social', 'Chill'] },
    { text: 'Visit a local museum', categories: ['Creative', 'Social'] },
    { text: 'Listen to a new podcast', categories: ['Chill'] },
    { text: 'Take a walk in the park', categories: ['Physical', 'Chill'] },
    { text: 'Watch a sunset', categories: ['Chill', 'Creative'] },
    { text: 'Sketch a street scene for 20 minutes', categories: ['Creative'] },
    { text: 'Join a short local meetup or event', categories: ['Social'] },
    { text: 'Try a new workout class', categories: ['Physical'] },
    { text: 'Prepare a new recipe from a different cuisine', categories: ['Creative', 'Chill'] },
  ];

  // DOM refs
  const navButtons = document.querySelectorAll('.nav-btn');
  const screens = document.querySelectorAll('.screen');
  const mainBtn = document.querySelector('.main-btn');
  const categoryButtons = document.querySelectorAll('.category-buttons button');
  const adventureBoxes = document.querySelectorAll('.adventure-box');
  const savedListEl = document.querySelector('.saved-list');

  // State
  let saved = loadSaved();

  // Navigation
  navButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      screens.forEach(s => s.classList.remove('active'));
      navButtons.forEach(b => b.classList.remove('active'));
      const screen = document.getElementById(btn.dataset.screen);
      if (screen) screen.classList.add('active');
      btn.classList.add('active');
      if (btn.dataset.screen === 'saved') renderSaved();
    });
  });

  // Generate random adventure (optionally by category).
  // Tries to use server API first; falls back to local ADVENTURES.
  async function randomAdventure(category) {
    // Try API fetch
    try {
      const url = category ? `/api/adventures?category=${encodeURIComponent(category)}` : '/api/adventures';
      const res = await fetch(url);
      if (res.ok) {
        const list = await res.json();
        if (!Array.isArray(list) || list.length === 0) return { text: 'No adventures found.' };
        const i = Math.floor(Math.random() * list.length);
        return list[i];
      }
    } catch (e) {
      // ignore network errors and fall back to local list
      // console.warn('API fetch failed, falling back to local pool', e);
    }

    const pool = category ? ADVENTURES.filter(a => a.categories.includes(category)) : ADVENTURES;
    if (pool.length === 0) return { text: 'No adventures found for this category.' };
    const i = Math.floor(Math.random() * pool.length);
    return pool[i];
  }

  // Update a given adventure-box element with an adventure object
  function updateAdventureBox(boxEl, adventure) {
    const textEl = boxEl.querySelector('.adventure-text');
    const saveBtn = boxEl.querySelector('.save-btn');
    if (textEl) textEl.textContent = adventure.text;
    if (saveBtn) {
      saveBtn.textContent = isSaved(adventure.text) ? '❤️' : '♡';
      saveBtn.onclick = () => toggleSave(adventure.text, saveBtn);
    }
  }

  // Wire main CTA
  if (mainBtn) {
    mainBtn.addEventListener('click', () => {
      const adv = randomAdventure();
      const homeBox = document.querySelector('#home .adventure-box');
      updateAdventureBox(homeBox, adv);
    });
  }

  // Wire category buttons (generate within category)
  categoryButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const cat = btn.dataset.category;
      const adv = randomAdventure(cat);
      const catBox = document.querySelector('#categories .adventure-box');
      updateAdventureBox(catBox, adv);
    });
  });

  // Save management
  function loadSaved() {
    try {
      const raw = localStorage.getItem(NAV_KEY);
      return raw ? JSON.parse(raw) : [];
    } catch (e) {
      console.error('Failed to load saved adventures', e);
      return [];
    }
  }

  function persistSaved() {
    try {
      localStorage.setItem(NAV_KEY, JSON.stringify(saved));
    } catch (e) {
      console.error('Failed to persist saved adventures', e);
    }
  }

  function isSaved(text) {
    return saved.includes(text);
  }

  function toggleSave(text, btnEl) {
    if (isSaved(text)) {
      saved = saved.filter(s => s !== text);
    } else {
      saved.push(text);
    }
    persistSaved();
    if (btnEl) btnEl.textContent = isSaved(text) ? '❤️' : '♡';
    renderSaved();
  }

  // Render saved list
  function renderSaved() {
    savedListEl.innerHTML = '';
    if (saved.length === 0) {
      savedListEl.innerHTML = '<div class="saved-item">No saved adventures yet.</div>';
      return;
    }
    saved.forEach(item => {
      const div = document.createElement('div');
      div.className = 'saved-item';
      div.textContent = item;
      const unBtn = document.createElement('button');
      unBtn.textContent = 'Remove';
      unBtn.style.float = 'right';
      unBtn.addEventListener('click', () => {
        saved = saved.filter(s => s !== item);
        persistSaved();
        renderSaved();
        // update any visible save buttons
        document.querySelectorAll('.adventure-box .save-btn').forEach(b => {
          const parentText = b.parentElement.querySelector('.adventure-text')?.textContent;
          if (parentText === item) b.textContent = '♡';
        });
      });
      div.appendChild(unBtn);
      savedListEl.appendChild(div);
    });
  }

  // Initialize adventure-box save buttons on page load
  document.querySelectorAll('.adventure-box').forEach(box => {
    const text = box.querySelector('.adventure-text')?.textContent || '';
    const saveBtn = box.querySelector('.save-btn');
    if (saveBtn) {
      saveBtn.textContent = isSaved(text) ? '❤️' : '♡';
      saveBtn.addEventListener('click', () => toggleSave(text, saveBtn));
    }
  });

  // Initial render
  renderSaved();
})();
