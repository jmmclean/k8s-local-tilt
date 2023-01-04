def uniq(iterable):
    """Returns a list of unique elements in `iterable`.
    Requires all the elements to be hashable.
    Args:
      iterable: An iterable to filter.
    Returns:
      A new list with all unique elements from `iterable`.
    """
    unique_elements = {element: None for element in iterable}

    # list() used here for python3 compatibility.
    # TODO(bazel-team): Remove when testing frameworks no longer require python compatibility.
    return list(unique_elements.keys())
