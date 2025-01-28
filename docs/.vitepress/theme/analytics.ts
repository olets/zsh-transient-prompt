declare global {
  interface Window {
    fathom: any;
  }
}

function trackLinksAndFathomEvents(): void {
  if (typeof window === "undefined") {
    return;
  }

  const root = document.body;

  function getChildEls(el: HTMLElement): HTMLElement[] {
    return Array.from(
      el.querySelectorAll("a, [data-fathom-event]"),
    ) as HTMLElement[];
  }

  function trackClick(els: HTMLElement[]): void {
    for (const el of els) {
      if (el.getAttribute("data-fathom-initialized") === "true") {
        continue;
      }

      el.addEventListener("click", ({ currentTarget }) => {
        const currentTargetElement = currentTarget as HTMLElement;

        const fathomEventId = [
          "Click",
          document.title,
          currentTargetElement.getAttribute("data-fathom-event-id") ||
            currentTargetElement.textContent,
        ].join("|");

        window?.fathom?.trackEvent(fathomEventId);
      });

      el.setAttribute("data-fathom-initialized", "");
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
        addedNodeElement.hasAttribute("data-fathom-event-id") ||
        addedNodeElement.tagName === "A"
      ) {
        els.push(addedNodeElement);
      }

      els.push(...getChildEls(addedNodeElement));
    }

    // initialize elements of interest that were added to the page
    trackClick(els);
  });

  // observe changes to `root` and to its children
  observer.observe(root, {
    childList: true,
    subtree: true,
  });

  // initialize elements of interest available at page load
  trackClick(getChildEls(root));
}

export { trackLinksAndFathomEvents };
