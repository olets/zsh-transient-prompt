declare global {
  interface Window {
    fathom: any;
    umami: any;
  }
}

function trackLinksAndTrackedEvents(): void {
  if (typeof window === "undefined") {
    return;
  }

  const root = document.body;

  function getChildEls(el: HTMLElement): HTMLElement[] {
    return Array.from(
      el.querySelectorAll("a, [data-track-event]"),
    ) as HTMLElement[];
  }

  function trackClick(els: HTMLElement[]): void {
    for (const el of els) {
      if (el.getAttribute("data-track-initialized") === "true") {
        continue;
      }

      el.addEventListener("click", ({ currentTarget }) => {
        const currentTargetElement = currentTarget as HTMLElement;

        const trackedEventId = [
          "Click",
          document.title,
          currentTargetElement.getAttribute("data-track-event-id") ||
            currentTargetElement.textContent,
        ].join("|");

        window?.fathom?.trackEvent(trackedEventId);

        window?.umami?.track(trackedEventId.substring(0, 50));
      });

      el.setAttribute("data-track-initialized", "");
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
        addedNodeElement.hasAttribute("data-track-event-id") ||
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

export { trackLinksAndTrackedEvents };
