1. Practical Assignment 1: Basic State with Model-View

- Step 4 introduces a StatefulWidget so that the app interface can dynamically update when data changes (for example, when users add or check off a task).

- Purpose: To make the app responsive to user interactions without having to restart the entire application.

- Why this is done: Using a StatefulWidget allows data changes to automatically trigger a UI rebuild through the setState() method, ensuring that the task list on screen always stays synchronized with the underlying data.

2. Why the plan Variable is Needed in Step 6

In Step 6, the plan variable is created as the main data model that stores all user tasks.

- Why it’s defined as a constant:
The plan model contains initial template data that does not change at runtime, so it’s defined as a constant for memory efficiency and code clarity.
However, the task list inside it is managed dynamically within the widget’s state.

- Conclusion:
plan serves as the single source of truth for the app’s data, used to display and update the user’s activity list.

3. Result of Step 9 (GIF and Explanation)

In Step 9, we create a function to add new tasks into the list by pressing the “+” button.
When the button is pressed:

- The TextField collects user input.
- The setState() function updates the task list.
- The new item immediately appears in the list view.

- Explanation:
The GIF above shows how the app dynamically adds items and refreshes the list view instantly without requiring a full restart.

4. Purpose of Methods in Steps 11 and 13 within the State Lifecycle

*Step 11 — initState()*

This method is called once when the widget is first created.
It is used to:

- Initialize the ScrollController.

- Add a listener to remove focus from any TextField when the user scrolls.

Purpose: To configure the widget’s initial setup before it appears on screen.

*Step 13 — dispose()*

This method is called when the widget is no longer in use (for example, when navigating away from the screen).
It is used to:

- Clean up resources used by the widget.

- Dispose of the ScrollController to prevent memory leaks.

Purpose: To ensure optimal performance by freeing unused resources and avoiding leaks.
