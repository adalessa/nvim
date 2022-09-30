;; extends

(block_mapping_pair
    key: (flow_node) @key.resolve (#eq? @key.resolve "resolve")
    value: (flow_node) @resolver
)
