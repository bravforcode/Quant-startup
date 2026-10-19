Tests for the startup-validation toolkit (python/)

The data in ../sample/ (interviews.csv, offers.csv) is SYNTHETIC. It was invented
to exercise kpi.py. It is not real interview or customer data.

Run from any directory (standard library only, no pip install):

    python3 -m unittest discover -s <repo>/startup-validation/python/tests -v
