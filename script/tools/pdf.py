"""
Modified from https://github.com/pymupdf/PyMuPDF-Utilities/blob/fc198c855e6c5ba9e1b33a5c1c0be7e83afdb58b/examples/extract-table/ParseTab.py.

Return a Python list of lists from the words found in a fitz.Document page
-------------------------------------------------------------------------------
License: GNU GPL V3
(c) 2018 Jorj X. McKie

Usage
-----
Used by extract.py and wx-extract.py

Notes
-----
(1) Works correctly for simple, non-nested tables only.

(2) Line recognition depends on the coordinates of the detected words in the
    rectangle. These will be round to integer (pixel) values. However, use of
    different fonts, scan inaccuracies, and so on, may lead to artefacts line
    differences, which must be handled by the caller.

Dependencies
-------------
PyMuPDF v1.12.0 or later
"""

from itertools import groupby
from operator import itemgetter

import fitz
from fitz.utils import get_text


# ==============================================================================
# Function ParseTab - parse a document table into a Python list of lists
# ==============================================================================
def parse_document_table(page: fitz.Page, bbox: list[int], columns=None):
    """Returns the parsed table of a page in a PDF / (open) XPS / EPUB document.
    Parameters:
    page: fitz.Page object
    bbox: containing rectangle, list of numbers [x_min, y_min, x_max, y_max]
    columns: optional list of column coordinates. If None, columns are generated
    Returns the parsed table as a list of lists of strings.
    The number of rows is determined automatically
    from parsing the specified rectangle.
    """
    tab_rect = fitz.Rect(bbox).irect
    x_min, y_min, x_max, y_max = tuple(tab_rect)

    if tab_rect.is_empty or tab_rect.is_infinite:
        print("Warning: incorrect rectangle coordinates!")
        return []

    if type(columns) is not list or columns == []:
        coltab = [tab_rect.x0, tab_rect.x1]
    else:
        coltab = sorted(columns)

    if x_min < min(coltab):
        coltab.insert(0, x_min)
    if x_max > coltab[-1]:
        coltab.append(x_max)

    words = get_text(page, "words", sort=True)

    if not words:
        print("Warning: page contains no text")
        return []

    all_txt = []

    # get words contained in table rectangle and distribute them into columns
    for w in words:
        ir = fitz.Rect(w[:4]).irect  # word rectangle
        if ir in tab_rect:
            cnr = 0  # column index
            for i in range(1, len(coltab)):  # loop over column coordinates
                if ir.x0 < coltab[i]:  # word start left of column border
                    cnr = i - 1
                    break
            all_txt.append([ir.x0, ir.y0, ir.x1, cnr, w[4]])

    if not all_txt:
        print("Warning: no text found in rectangle!")
        return []

    all_txt.sort(key=itemgetter(1))  # sort words vertically

    # create the table / matrix
    span_tab = []  # the output matrix

    for y, zeile in groupby(all_txt, itemgetter(1)):
        schema = [""] * (len(coltab) - 1)
        for c, words in groupby(zeile, itemgetter(3)):
            entry = " ".join([w[4] for w in words])
            schema[c] = entry
        span_tab.append(schema)

    return span_tab
