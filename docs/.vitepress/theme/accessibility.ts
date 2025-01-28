function scrollableRegionsHaveKeyboardAccess(): void {
  if (typeof window === "undefined") {
    return;
  }

  const root = document.body;

  function getChildEls(el: HTMLElement): HTMLElement[] {
    return Array.from(el.querySelectorAll(".vp-code code")) as HTMLElement[];
  }

  function addTabindex(els: HTMLElement[]): void {
    for (const el of els) {
      if (el.getAttribute("tabindex") === "0") {
        continue;
      }

      el.setAttribute("tabindex", "0");
    }
  }

  const observer = new MutationObserver((mutationRecords) => {
    const addedNodes = mutationRecords.flatMap((mutationRecord) => {
      return Array.from(mutationRecord.addedNodes);
    });

    const els: HTMLElement[] = [];

    for (const addedNode of addedNodes) {
      // @ts-expect-error ts(2339)
      if (!addedNode?.hasAttribute) {
        continue;
      }

      const addedNodeElement = addedNode as HTMLElement;

      if (
        addedNodeElement.tagName === "CODE" &&
        addedNodeElement.parentElement?.classList.contains(".vp-code")
      ) {
        els.push(addedNodeElement);
      }

      els.push(...getChildEls(addedNodeElement));
    }

    // initialize elements of interest that were added to the page
    addTabindex(els);
  });

  // observe changes to `root` and to its children
  observer.observe(root, {
    childList: true,
    subtree: true,
  });

  // initialize elements of interest available at page load
  addTabindex(getChildEls(root));
}

export { scrollableRegionsHaveKeyboardAccess };
